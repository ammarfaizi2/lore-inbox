Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287502AbSA1XKx>; Mon, 28 Jan 2002 18:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287513AbSA1XKj>; Mon, 28 Jan 2002 18:10:39 -0500
Received: from ns.ithnet.com ([217.64.64.10]:4 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287502AbSA1XKP>;
	Mon, 28 Jan 2002 18:10:15 -0500
Message-Id: <200201282309.AAA22703@webserver.ithnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Hood <jdthood@mail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 Jan 2002 00:09:32 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0201290351520.7623-100000@boston.corp.fedex.com>
Content-Transfer-Encoding: 7BIT
Subject: Re: 2.4.18-pre7 slow ... apm problem
To: Jeff Chua <jchua@fedex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                                                     
> On Sun, 27 Jan 2002, Stephan von Krawczynski wrote:                 
>                                                                     
> > > 1) keyboard rate is a bit slow on 2.4.18-pre7 compared to       
2.4.18-pre6.                                                          
> > What _exactly_ does this mean? Can you elaborate more on your     
setup and                                                             
> > your problem?                                                     
>                                                                     
> Sorry, just got off a long flight from San Diego to Singapore.      
Anyway,                                                               
> slow ... means that even without vmware, if I just hit return, the  
lines                                                                 
> would scroll for about every 10 lines and there'll be a litte pause 
(<0.3                                                                 
> sec). With pre6, there's no such behavior, and if                   
CONFIG_APM_CPU_IDLE is                                                
> not set, the "pause" goes away.                                     
                                                                      
Ok, I cannot see this one, I have no APM enabled on my boxes. Sorry.  
                                                                      
> > > 2) On vmware 3.0, ping localhost is very slow. 2.4.18-pre6 has  
not                                                                   
> > such problem.                                                     
> > 1) linux with vmware and guest system linux                       
>                                                                     
> "host" system is linux. "guest" system is linux (actually, I tried  
with NT                                                               
> as well, same problem).                                             
>                                                                     
> The sympton is when I try to ping the "host" from vmware's "guest"  
system,                                                               
> the first response came back to the guest's console. Then if I don't
type                                                                  
> anything or don't move the mouse on the guest's console, I won't see
any                                                                   
> further response on the guest's linux console. Even with a lot of   
mouse                                                                 
> movement or pressing the keys, the response is still very slow with 
"ping".                                                               
                                                                      
This is interesting.                                                  
I have not set up a guest linux yet, but I experienced a problem with 
Win98 guest which may sound related:                                  
I start the guest win98 and try to open a dos-window. The window opens
but no output is presented (no prompt, no nothing) and guest system   
somehow "hangs". Sometimes (rarely) I can make it work again by       
hitting keys on the keyboard. The effect started off as window coming 
up with prompt, I tried to ping the host system, and the first packet 
was somehow slow, but then everything was ok. On the next guest boot, 
some output appeared at the dosbox, but the prompt was delayed. Now I 
get no prompt no matter what I try.                                   
Host system is 2.4.18-pre7.                                           
Vmware was installed from scratch, win98 guest was installed from     
scratch with no additions whatsoever.                                 
ping from host to guest works flawlessly.                             
                                                                      
> If I ping from the "host" linux console to the "guest" linux system,
> responses came back, and does not hang. I'll double check this last 
point.                                                                
> Got to recompile the kernel again.                                  
                                                                      
As I never saw this with vmware 2 (even not on 2.4.18-pre7) I would   
say version 3 has a real problem somewhere.                           
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
