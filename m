Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264807AbTFESan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 14:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbTFESan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 14:30:43 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:6859 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264865AbTFESam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 14:30:42 -0400
Message-ID: <3EDF8FCD.4020502@austin.ibm.com>
Date: Thu, 05 Jun 2003 13:45:33 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: re: Nightly regression run results
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 
http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-mm1/2.5.70-vs-2.5.70-mm1/

This shows a significant (20%) degrade for SpecSDET in the mm1 tree.   
The degrade carries forward in the mm2 and mm3 trees.    I see lots more 
calls to page_remove_rmap and page_add_rmap in the profile for mm1.  Not 
sure if this is the issue, but probably needs to be looked at.

Steve

