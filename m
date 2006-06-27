Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWF0Peb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWF0Peb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWF0Peb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:34:31 -0400
Received: from services110.cs.uwaterloo.ca ([129.97.152.166]:49397 "EHLO
	services110.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1161109AbWF0Pea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:34:30 -0400
Message-ID: <44A14FE0.4080204@uwaterloo.ca>
Date: Tue, 27 Jun 2006 11:33:52 -0400
From: Weihan Wang <w23wang@uwaterloo.ca>
Organization: University of Waterloo, Canada
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: splice() doens't support socket as input?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Miltered: at minos with ID 44A15000.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I'm right, splice() in 2.6.17 doesn't support sockets as input yet 
(from the fact that socket_file_ops.splice_read == 0). So what is the 
anticipated version to add support of sockets as input? Thanks.

Weihan
