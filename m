Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUIVXJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUIVXJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUIVXJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:09:55 -0400
Received: from imap.gmx.net ([213.165.64.20]:16098 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268104AbUIVXIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:08:32 -0400
X-Authenticated: #5395555
Message-ID: <415204E0.9010203@gmx.net>
Date: Thu, 23 Sep 2004 01:04:00 +0200
From: Judith und Mirko Kloppstech <jugal@gmx.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suggestion for CD filesystem for Backups
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can use CDs or DVDs for Backup purposes. They do error correction, 
everything is fine, until the errors get too much, than everything is 
lost. This is a nuisance for a backup, especially because normal people 
don't have the hardware to measure errors, jitter and the like.

Suggestion:
Why not write a file system on top of ISO9660 which uses the rest of the 
CD to write error correction. If a sector becomes unreadable, the error 
correction saves the data. Besides, a tool for testing the error rate 
and the safety of the data can be easily written for a normal CD-ROM drive.

The data for error correction might be written into a file so that the 
CD can be read using any System, but Linux provides error correction.

Mirko Kloppstech

