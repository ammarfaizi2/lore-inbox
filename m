Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129709AbRB0Vqs>; Tue, 27 Feb 2001 16:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRB0Vqj>; Tue, 27 Feb 2001 16:46:39 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:37360 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129709AbRB0Vq0>; Tue, 27 Feb 2001 16:46:26 -0500
Date: Tue, 27 Feb 2001 18:32:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "David L. Nicol" <david@kasey.umkc.edu>
cc: Zack Brown <zbrown@tumblerings.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Will Mosix go into the standard kernel?
In-Reply-To: <3A9C1A3A.8BC1BCF2@kasey.umkc.edu>
Message-ID: <Pine.LNX.4.33.0102271829030.5502-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, David L. Nicol wrote:

> I've thought that it would be good to break up the different
> clustering frills -- node identification, process migration,
> process hosting, distributed memory, yadda yadda blah, into
> separate bite-sized portions.

It would also be good to share parts of the infrastructure
between the different clustering architectures ...

> Is there a good list to discuss this on?  Is this the list?
> Which pieces of clustering-scheme patches would be good to have?

I know each of the cluster projects have mailing lists, but
I've never heard of a list where the different projects come
together to eg. find out which parts of the infrastructure
they could share, or ...

Since I agree with you that we need such a place, I've just
created a mailing list:

	linux-cluster@nl.linux.org

To subscribe to the list, send an email with the text
"subscribe linux-cluster" to:

	majordomo@nl.linux.org


I hope that we'll be able to split out some infrastructure
stuff from the different cluster projects and we'll be able
to put cluster support into the kernel in such a way that
we won't have to make the choice which of the N+1 cluster
projects should make it into the kernel...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

