Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbQKHTr6>; Wed, 8 Nov 2000 14:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129224AbQKHTrr>; Wed, 8 Nov 2000 14:47:47 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:8652 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129102AbQKHTrf>; Wed, 8 Nov 2000 14:47:35 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: George Anzinger <george@mvista.com>
Subject: Re: Installing kernel 2.4
Date: Wed, 8 Nov 2000 19:43:46 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011081205.eA8C5ui27838@pincoya.inf.utfsm.cl> <00110816543500.01639@dax.joh.cam.ac.uk> <3A098F11.1B89EB7B@mvista.com>
In-Reply-To: <3A098F11.1B89EB7B@mvista.com>
MIME-Version: 1.0
Message-Id: <00110819463200.01915@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2000, George Anzinger wrote:
> But, here the customer did run the configure code (he said he did not
> change anything).  Isn't this where the machine should be diagnosed and
> the right options chosen?  Need a way to say it is a cross build, but
> that shouldn't be too hard.

Why default to incompatibility?! If the user explicitly says "I really do want
a kernel which only works on this specific machine as it is now, and I want it
to break otherwise", fine. Don't make it a default!

BTW: Has anyone benchmarked the different optimizations - i.e. how much
difference does optimizing for a Pentium make when running on a PII? More to
the point, how about optimizing non-exclusively for a Pentium, so the code
still runs on earlier CPUs?


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
