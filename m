Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbTHZWda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbTHZWcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:32:45 -0400
Received: from mail.gondor.com ([212.117.64.182]:19980 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S263012AbTHZWcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:32:10 -0400
Date: Wed, 27 Aug 2003 00:31:58 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Promise IDE patches
Message-ID: <20030826223158.GA25047@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Two weeks ago, I tried two patches against 2.4.21 regarding LBA48
support. One limits the size of a drive to 137GB if LBA48 is not
available. Without this patch, severe data corruption is possible.

http://gondor.com/linux/patch-limit48-2.4.21

The other one is making LBA48 support work with pdc 20265 controllers. 

http://gondor.com/linux/patch-pdc-lba48-2.4.22

I think they should be candidates for inclusion in 2.4.23, as well as
a fix for hdparm -I (and other commands going directly to the drive) on
(some?) promise controllers:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104250818527780&w=2

Jan

