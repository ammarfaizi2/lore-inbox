Return-Path: <linux-kernel-owner+w=401wt.eu-S932340AbXAGCXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbXAGCXi (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbXAGCXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:23:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47934 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932340AbXAGCXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:23:37 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: gclion@mail.ru
Subject: Re: qconf handling NULL pointers
Date: Sun, 7 Jan 2007 03:23:04 +0100
User-Agent: KMail/1.9.5
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <200701061444.18384.gclion@mail.ru>
In-Reply-To: <200701061444.18384.gclion@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701070323.05804.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 06 January 2007 12:44, Cyrill V. Gorcunov wrote:

> I found qconf have a few malloc(), strdup() without any check for NULL
> returned code. May be it should be fixed? Am I wrong?

The code isn't really supposed to deal with it, at most they could be replaced 
with a variant that prints an error message and exits.

bye, Roman
