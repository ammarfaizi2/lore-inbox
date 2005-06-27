Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVF0GZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVF0GZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVF0GYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:24:08 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:29704 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261859AbVF0GWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:22:13 -0400
Message-ID: <42BF9B09.8020906@slaphack.com>
Date: Mon, 27 Jun 2005 01:22:01 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506270505.j5R55Zsx005315@laptop11.inf.utfsm.cl>
In-Reply-To: <200506270505.j5R55Zsx005315@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand wrote:
> David Masover <ninja@slaphack.com> wrote:
> 
>>Hans Reiser wrote:
> 
> 
> [...]
> 
> 
>>>Reiser4 plugins are not per user, but per kernel.  They are compiled
>>>in.  The model is intended to ease the development process, nothing
>>>more.  Apologies if the naming suggests more.
> 
> 
> What do you gain by this? It is just a kernel configuration option of
> sorts? Just name mangling of existing mechanisms for no good reason at all?

I don't know why it's named "plugins", but the mechanism itself gains a
lot.  For one thing, certain new "plugins" for new kinds of files
(cryptocompressed files, for instance) can be almost as easy as new
plugins for (say) XMMS.

Still, Hans, it's high time to either rename these "plugins" or start
talking about bytecode engines...

>>But, to avoid confusion, the inclusion of a crytocompress plugin in a
>>given kernel doesn't mean that all files accessed from that kernel are
>>encrypted and compressed.  It just means that you can pick an individual
>>file and set it to be transparently encrypted/compressed.
>>
>>That is what I meant by "enabled".  Not per-user, but per-file.
> 
> 
> Wonderful! I carefully "transparently encrypt" my secret files, so
> /everybody/ can read them! Now /that/ is progress!

Explain to me how this is worse than how you currently encrypt your
secret files?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr+bCHgHNmZLgCUhAQKnag/8DF1PjfQwEYaJWUOOY0roqn6b+/L8X/X1
kgFE3SyPJkNRuY6X/J3EQUht5v/EBEbk2ZE/oTWB+HGEeUv1juUmG7z2rWCvi8sY
tXPG28iqOAjwvZa+2aq8o4ptW0+gaXVIbrNGEaWTXPgbxdxtoVMOAakBJl3FUchK
pwZWJD+msuQuPFc42zQ3Zdvp+4/NhhC6qcSpZ9DGXHO9uDJDDdl3Xgf9+qOD+W7Y
Bz4sGfNphIbJjydHs0DdcZPh49MhS+qd48Qw1WFskalF9dhZhHFq3MKIBFbg8bA8
MX9yY5XHrNPJqJXF96YtcJV9nZcXh4qEz81/JC7V+VYm/BME20a0jtUt5bMtGRjj
kC8FxzVvamOmeXnzRnU2DKIlGlfTUmK1u6wQpMsoiwPZr9WH7WRxiP/tHPVYQbBc
gPpg7POOz3M6Q3guZMGTxeYu7kHJm8s/zJVwXm04fz+03hrkab1q/w4cT0SaX4Pv
naipO7nkdr5qoRzF2sBSZAsnauxGa0ViR0TP715FN+oX0ZRiSQcgEGc+zXz6qPb5
bSz29jG1iGkrepB6LU88gMZiyxc2qK1SHpZlKjn9iPKqpxpwEtpQToUBhRsAlFBv
9Z6KxrQYrUYfJ/Z9ktIUuvsvN3zbnnc7tmZGYNisqm03dq61kguAwOV66INSlYDj
gFaw23Z9X58=
=xsgf
-----END PGP SIGNATURE-----
