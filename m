Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbSACJPN>; Thu, 3 Jan 2002 04:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285048AbSACJPD>; Thu, 3 Jan 2002 04:15:03 -0500
Received: from t2.redhat.com ([199.183.24.243]:45046 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285023AbSACJO7>; Thu, 3 Jan 2002 04:14:59 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020102220333.A26713@thyrsus.com> 
In-Reply-To: <20020102220333.A26713@thyrsus.com>  <20020102211038.C21788@thyrsus.com> <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de> 
To: esr@thyrsus.com
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 09:14:48 +0000
Message-ID: <4115.1010049288@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric, what are you doing to do if you _do_ detect that there are ISA slots 
present? If there are ISA (not isapnp) cards present, you'll _have_ to 
start asking 'difficult' questions. So why bother to detect the ISA slots 
automatically? Just hide the ISA_SLOTS option in idiotmode. 

I hope you haven't added ISA_SLOTS to the version of CML2 you're intending 
to submit for 2.5, btw. That would violate the agreement which you seem to 
have made that you'd make the first version of CML2 match the existing CML1 
rules as far as possible, and introduce orthogonal changes later in 
individual patches. 


--
dwmw2


