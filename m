Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUCPUBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUCPUBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:01:08 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:10686 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261610AbUCPUAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:00:36 -0500
Message-ID: <40575CCE.4050905@nortelnetworks.com>
Date: Tue, 16 Mar 2004 15:00:14 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
References: <200403161919.i2GJJIED007767@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

> OK, let's see... I've got a laptop, on CD is the "original" kernel tree, on
> HD is my modified stuff. I delete a file (or move it). Then I pack up, go
> home. There I start up again. How is the fact that the file is gone recorded?

If I recall, directory inodes list the files in that directory. 
Presumably you had to write to the directory inode to do the delete. 
The new version of the directory is now stored on the HD.  It lists the 
original files on the CD, minus the one that was deleted.

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

