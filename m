Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUEAAll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUEAAll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 20:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUEAAlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 20:41:40 -0400
Received: from mesa.unizar.es ([155.210.11.66]:64490 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S261875AbUEAAlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 20:41:39 -0400
Date: Sat, 1 May 2004 02:40:14 +0200
From: Jorge Bernal <koke@sindominio.net>
To: Marc Boucher <marc@linuxant.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040501004014.GA5256@amedias.org>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 04:11:29PM -0400, Marc Boucher wrote:
> 
> The purpose of the workaround is not to circumvent any protection, but 
> to fix a real usability issue for systems in the field, which, as an 
> expert you perhaps do not see, but users definitely massively felt and 
> complained about.
> 

You have argued this a lot of times during this thread and I want to say
smoenthing about that. I have used some binary-only modules: nvidia,
vmware and some time ago HSF drivers. When I installed the nvidia
propetary driver was the first time I saw the word 'tainted' and it
makes sense: I was at the console.

I mean that most of users work on X (except when installing X drivers
:)) and probably they will never see this "confusing" warnings.

When my system boots, it loads the nvidia and vmware modules and most of
time (I could say always) I don't notice that my kernel is tainted
(though I know) so I don't see the reason to hide the license.

I think it should be good for all to stop flaming and put some things in
order. You have lied about the license and it seems you want to keep
lying so -quoting Linus- it seems you don't have shame.

Cheers,
	Koke

-- 
"Sólo el éxito diferencia al genio del loco"

Blog: http://www.amedias.org/koke
Web Personal: http://sindominio.net/~koke/
JID: koke@zgzjabber.ath.cx
