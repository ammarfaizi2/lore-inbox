Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbTJIPWa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTJIPWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:22:30 -0400
Received: from imr2.ericy.com ([198.24.6.3]:44986 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S262224AbTJIPW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:22:29 -0400
Message-ID: <3F857E63.8050304@ericsson.ca>
Date: Thu, 09 Oct 2003 11:27:31 -0400
From: Jean-Guillaume <jean-guillaume.paradis@ericsson.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: ProcFs: FORCING  remove_proc_entry even if the directory is used
  (busy)  ??
References: <3F786E73.6010306@ericsson.ca>
In-Reply-To: <3F786E73.6010306@ericsson.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
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
