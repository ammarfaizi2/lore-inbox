Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285063AbRLFJkz>; Thu, 6 Dec 2001 04:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285078AbRLFJkq>; Thu, 6 Dec 2001 04:40:46 -0500
Received: from t2.redhat.com ([199.183.24.243]:762 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285070AbRLFJki>; Thu, 6 Dec 2001 04:40:38 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011206.001423.118949508.davem@redhat.com> 
In-Reply-To: <20011206.001423.118949508.davem@redhat.com>  <11777.1007619756@kao2.melbourne.sgi.com> <3C0F27CA.59C22DEF@mandrakesoft.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@mandrakesoft.com, kaos@ocs.com.au, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Dec 2001 09:40:19 +0000
Message-ID: <15133.1007631619@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
> >    Why not __attribute__((weak)) ?
> This doesn't work on all platforms unfortunately :( 

Doesn't work at all, or just doesn't work with the (current) minimum
recommended compiler? We have to increase those minima at some point. 

--
dwmw2


