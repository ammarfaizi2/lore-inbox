Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbTJPJ3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 05:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTJPJ3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 05:29:09 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:36502 "EHLO
	mwinf0401.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262783AbTJPJ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 05:29:07 -0400
Date: Thu, 16 Oct 2003 11:29:06 +0200
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031016092906.GA6602@iliana>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031016091918.GA1002@casa.fluido.as>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 11:19:18AM +0200, Carlo E. Prelz wrote:
>  /* Radeon RV280 (9200) */
>  #define PCI_DEVICE_ID_ATI_RADEON_Y_    0x5960
> +#define PCI_DEVICE_ID_ATI_RADEON_Yz    0x5964
>  /* Radeon R300 (9500) */
>  #define PCI_DEVICE_ID_ATI_RADEON_AD    0x4144
>  /* Radeon R300 (9700) */
> 
> (I did not know how to call it. _Yz did not exist, so I grabbed it. Is
> there any logic in these codes?)

You use the ascii code of the id :

  0x41 -> A, 0x44 -> D thus 0x4144 -> AD.

So, the 0x5964 must be Yd.

Friendly,

Sven Luther
