Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUEMUtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUEMUtc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbUEMUtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:49:32 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:8716 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264795AbUEMUtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 16:49:09 -0400
Date: Thu, 13 May 2004 17:48:22 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: eric.valette@free.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2 : Hitting Num Lock kills keyboard
Message-ID: <20040513204822.GA723@lorien.prodam>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	eric.valette@free.fr, linux-kernel@vger.kernel.org
References: <40A3C951.9000501@free.fr> <40A3CF97.5000405@free.fr> <20040513125750.59434a33.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513125750.59434a33.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 13, 2004 at 12:57:50PM -0700, Andrew Morton escreveu:

| Eric Valette <eric.valette@free.fr> wrote:
| >
| > Eric Valette wrote:
| > > Andrew,
| > > 
| > > I tested 2.6.6-mm2 this afternoon and twice I totally lost my keyboard. 
| > 
| > Well, I can reproduce it at will : I just need to hit the numlock key 
| > and keyboard is frozen.
| 
| Could you please do
| 
| 	patch -p1 -R -i bk-input.patch
| 
| and see if it fixes it?

 Did that and fixed to me.

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
