Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTJIRQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTJIRQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:16:18 -0400
Received: from imr2.ericy.com ([198.24.6.3]:57245 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S262291AbTJIRQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:16:16 -0400
Message-ID: <3F85990F.6070902@ericsson.ca>
Date: Thu, 09 Oct 2003 13:21:19 -0400
From: Jean-Guillaume <jean-guillaume.paradis@ericsson.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ProcFs: FORCING  remove_proc_entry even if the directory is used
  (busy)  ??
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   I have a program that automaticaly recreate a directory in /proc, 
based on some events. To do this, I do a remove_proc_entry, and then 
recreate the directory.

   However, if someone is using a console and is currently IN my /proc 
directory, remove_proc_entry fails, saying that the dir is "busy".

   Any way to force the deletion? Or any ideas for workarounds?


   Many thanks

      Jena-Guillaume
