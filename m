Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263624AbUEKUhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUEKUhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUEKUhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:37:16 -0400
Received: from alkom.eunet.lv ([194.8.5.86]:56449 "EHLO new.solutions.lv")
	by vger.kernel.org with ESMTP id S263624AbUEKUg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:36:26 -0400
Date: Tue, 11 May 2004 23:36:28 +0300
From: Dmitry Ivanov <dimss@solutions.lv>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       mikeserv@bmts.com
Subject: Re: linux-2.6.6: ide-disks are shutdown on reboot
Message-ID: <20040511203628.GA30754@new.solutions.lv>
References: <20040511142017.1bc39ce1.vmlinuz386@yahoo.com.ar> <40A133BF.90403@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A133BF.90403@keyaccess.nl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 10:12:47PM +0200, Rene Herman wrote:
> +	if (system_state != SYSTEM_RESTART) {

drivers/ide/ide-disk.c:1707: error: `SYSTEM_RESTART' undeclared
(first use in this function)

I cannot find definition of SYSTEM_RESTART with grep too.

-- 
I am a viral sig. Please copy me and help me spread. Thank you.
