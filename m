Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278551AbRJSRGW>; Fri, 19 Oct 2001 13:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278554AbRJSRGM>; Fri, 19 Oct 2001 13:06:12 -0400
Received: from t2.redhat.com ([199.183.24.243]:43003 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S278551AbRJSRGJ>; Fri, 19 Oct 2001 13:06:09 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011019103041.D30774@taral.net> 
In-Reply-To: <20011019103041.D30774@taral.net>  <3bceefa6.3cf6.0@panix.com> <3BCEF26E.12D69882@redhat.com> 
To: Taral <taral@taral.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Oct 2001 18:06:40 +0100
Message-ID: <16082.1003511200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


taral@taral.net said:
>  Fine. I (the hypothetical binary driver maker) will just make two
> modules -- one which is MODULE_LICENCEd GPL, and the other which is
> not. The first will re-export your interfaces as unrestricted ones
> which the second can use.

You seem to have missed the point that it is already considered to be 
unacceptable to add GPL'd code to the kernel, exporting functionality which 
is required for non-GPL'd modules. 

--
dwmw2


