Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTGaX72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267634AbTGaX72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:59:28 -0400
Received: from remt24.cluster1.charter.net ([209.225.8.34]:45788 "EHLO
	remt24.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262385AbTGaX71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:59:27 -0400
Message-ID: <3F29AD69.3020109@mrs.umn.edu>
Date: Thu, 31 Jul 2003 18:59:37 -0500
From: Grant Miner <mine0057@mrs.umn.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: fun or real: proc interface for module handling?
References: <20030731121248.GQ264@schottelius.org>
In-Reply-To: <20030731121248.GQ264@schottelius.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool idea!  Maybe for each module, it could have a subdirectory to it 
(like reiser4's files-as-directory (see 
http://www.namesys.com/v4/pseudo.html)) and in that subdirectory are 
files to configure the options.  You take your module, module.ko, and 
you want to set some options (before or after loading it).  Maybe you 
could do something like
echo "true" > module.ko/option for your module.  Then you just
cp module.ko /proc/modules or whatever directory to insert?

