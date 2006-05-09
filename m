Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWEIXd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWEIXd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWEIXd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:33:58 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:43157 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932100AbWEIXd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:33:57 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: [PATCH] Fix console utf8 composing
Date: Wed, 10 May 2006 01:31:01 +0200
User-Agent: KMail/1.9.1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0604022005290.12603@yvahk01.tjqt.qr> <Pine.LNX.4.61.0605082211580.20743@yvahk01.tjqt.qr> <44604977.1090008@ums.usu.ru>
In-Reply-To: <44604977.1090008@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605100131.02692.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Just for the archive...

On Tuesday, 9. May 2006 09:49, Alexander E. Patrakov wrote:
> Both the current situation and my patch share the defect that an accent 
> cannot be put on top of a multibyte character, such as Greek letter alpha.

This is also a problem for proper Vietnamese console support, 
which requires two accents per character. 
Like "~" on top of "^" ontop of "a".


Regards

Ingo Oeser

