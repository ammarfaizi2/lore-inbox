Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293209AbSCEOmp>; Tue, 5 Mar 2002 09:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293206AbSCEOmf>; Tue, 5 Mar 2002 09:42:35 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:49925 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S293194AbSCEOm1>;
	Tue, 5 Mar 2002 09:42:27 -0500
Message-Id: <200203051443.JAA02111@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Mon, 04 Mar 2002 21:34:02 PST."
             <3C8458CA.30203@zytor.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Mar 2002 09:43:37 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com said:
> This is not necessarily a bad thing, however.  If the user hadn't set
> up  enough swap, they're probably better off getting the error message
> early. 

This is not a situation in which a lack of swap or a lack of RAM is a problem.

The problem is a tmpfs filling up.

You think that UML refusing to run if it can't get every bit of memory it
might ever need is preferable to UML running fine in somewhat less memory?

				Jeff

