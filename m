Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132555AbRDWX0C>; Mon, 23 Apr 2001 19:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRDWXZo>; Mon, 23 Apr 2001 19:25:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:36109 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132555AbRDWXZF>; Mon, 23 Apr 2001 19:25:05 -0400
Date: Mon, 23 Apr 2001 20:24:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alexander Viro <viro@math.psu.edu>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <Pine.GSO.4.21.0104231852520.4968-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0104232023400.17635-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, Alexander Viro wrote:
> On Mon, 23 Apr 2001, Richard Gooch wrote:
>
> > - keep a separate VFSinode and FSinode slab cache
>
> Yup.

Would it make sense to unify these with the struct
address_space ?

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

