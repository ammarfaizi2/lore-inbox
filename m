Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288447AbSANAd7>; Sun, 13 Jan 2002 19:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288449AbSANAdv>; Sun, 13 Jan 2002 19:33:51 -0500
Received: from ns.ithnet.com ([217.64.64.10]:56850 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288452AbSANAdl>;
	Sun, 13 Jan 2002 19:33:41 -0500
Message-Id: <200201140033.BAA04292@webserver.ithnet.com>
Cc: zippel@linux-m68k.org (Roman Zippel), alan@lxorguk.ukuu.org.uk (Alan Cox),
        rml@tech9.net (Robert Love), ken@canit.se (Kenneth Johansson),
        arjan@fenrus.demon.nl, landley@trommello.org (Rob Landley),
        linux-kernel@vger.kernel.org
Date: Mon, 14 Jan 2002 01:33:02 +0100
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <E16Prv5-00080m-00@the-village.bc.nu>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't doubt that, but would you seriously consider the ll patch 
for                                                                   
> > inclusion into the main kernel?                                   
>                                                                     
> The mini ll patch definitely.                                       
                                                                      
Huh?                                                                  
Can you point at anyone who experienced a significant benefit from it?
I can see a lot of interesting patches ahead if you let this go.      
Tell me honestly that the idea behind this patch is not _crap_. You   
can only make this basic idea work if you patch a tremendous lot of   
those conditional_schedules() through the kernel. We already saw it   
starting off in some graphics drivers, network drivers. Why not just  
all of it? You will not be far away in the end from the 'round 4000 I 
already stated in earlier post.                                       
I do believe Roberts' preempt is a lot cleaner in its idea _how_ to   
achieve basically the same goal. Although I am at least as sceptic as 
you about a race-free implementation.                                 
                                                                      
> The full ll one needs some head scratching to                       
> be sure its correct.                                                
                                                                      
You may simply call it _counting_ (the files to patch).               
                                                                      
> pre-empt is a 2.5 thing which in some ways is easier                
> because it doesnt matter if it breaks something.                    
                                                                      
So I understand you agree somehow with me in the answer to "what idea 
is really better?"...                                                 
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
