Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291706AbSBALbn>; Fri, 1 Feb 2002 06:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291713AbSBALbd>; Fri, 1 Feb 2002 06:31:33 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:57106 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291706AbSBALbR>;
	Fri, 1 Feb 2002 06:31:17 -0500
Date: Fri, 1 Feb 2002 09:30:56 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Larry McVoy <lm@work.bitmover.com>, Keith Owens <kaos@ocs.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.LNX.4.33L.0202010926080.17106-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Horst von Brand wrote:

> I wonder how your commercial customers develop code then. Either each
> programmer futzes around in his/her own tree, and then creates a patch
> (or some such) for everybody to see (then I don't see the point of
> source control as a help to the individual developer), or everybody
> sees all the backtracking going on everywhere (in which case the
> repository is a mostly useless mess AFAICS).

If the object is to minimise confusion by not showing
back-tracked changes, why not simply allow the user
to mark changesets with a "visibility":

1) hidden, for stuff which shouldn't be seen by default,
   like backed out changes, etc..
2) small, individual development steps to achieve a new
   feature
3) normal, the normal commits
4) major (tagged versions ?)

This way the user can select how detailed the overview
of the versions should be.

Also, when viewing a changeset/version of a certain
priority, bitkeeper could optionally "fold in" the
hidden changesets between the last changeset and the
one the user wants to view.

Would this be a workable scheme ?

(keeps the bitkeeper repository intact, can reduce
the confusion)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

