Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266916AbUGVTzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266916AbUGVTzr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUGVTzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:55:47 -0400
Received: from sampa1.prodam.sp.gov.br ([200.230.190.2]:51728 "EHLO
	netlab96.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S266916AbUGVTzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:55:45 -0400
Date: Thu, 22 Jul 2004 16:44:20 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Lei Yang <leiyang@nec-labs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compression filter for Loopback device
Message-ID: <20040722194420.GG1311@lorien.prodam>
Mail-Followup-To: Lei Yang <leiyang@nec-labs.com>,
	linux-kernel@vger.kernel.org
References: <951A499AA688EF47A898B45F25BD8EE80126D4D6@mailer.nec-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951A499AA688EF47A898B45F25BD8EE80126D4D6@mailer.nec-labs.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Lei,

Em Thu, Jul 22, 2004 at 03:27:17PM -0400, Lei Yang escreveu:

| Is there anything like 'losetup' that allows choosing encryption
| algorithm for a loopback device that can be used on compression
| algorithms? Or in other words, when the data passes through loopback
| device to a real storage device, it can be filtered and the filter is
| compression instead of encryption; when kernel ask for data in a storage
| device that is mounted to a loopback device with compression, it will be
| filtered again -- decompressed.
| 
| If there is not a ready-to-use method for this, is there any way I can
| implement the idea?
| 
| TIA! Really appreciate any comments.

 maybe you can a try a mix: cloop + cryptloop (or something like
that), but it will be kludge.

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
