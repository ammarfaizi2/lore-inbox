Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbTAJSkb>; Fri, 10 Jan 2003 13:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbTAJSjk>; Fri, 10 Jan 2003 13:39:40 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:29950 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S266199AbTAJSi4>;
	Fri, 10 Jan 2003 13:38:56 -0500
Date: Fri, 10 Jan 2003 19:47:39 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030110184739.GA1579@werewolf.able.es>
References: <Pine.LNX.4.44.0301100921460.12833-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0301100921460.12833-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 10, 2003 at 18:29:36 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.10 Linus Torvalds wrote:
> 
> On Fri, 10 Jan 2003, Dave Jones wrote:
> > 
> > What's happening with the OSS drivers ?
> > I'm still carrying a few hundred KB of changes from 2.4 for those.
> > I'm not going to spent a day splitting them up, commenting them and pushing
> > to Linus if we're going to be dropping various drivers.
> 
> I consider them to be old drivers, the same way "hd.c" was. Not
> necessarily useful for most people, but neither was hd.c. And it was
> around for a _long_ time (heh. I needed to check. The config option is 
> still there ;)
> 
> So I don't see a huge reason to remove them from the sources, but we might
> well make them harder to select by mistake, for example. Right now the
> config help files aren't exactly helpful, and the OSS choice is before the
> ALSA one, which looks wrong. 
> 
> They should probably be marked deprecated, and if they don't get a lot of 
> maintenance, that's fine.
> 
> 		Linus

As there is a CONFIG_EXPERIMENTAL, how about a CONFIG_DEPRECATED for the
opposite edge ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
