Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSL3XJ4>; Mon, 30 Dec 2002 18:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbSL3XJ4>; Mon, 30 Dec 2002 18:09:56 -0500
Received: from adedition.com ([216.209.85.42]:36113 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265174AbSL3XJx>;
	Mon, 30 Dec 2002 18:09:53 -0500
Date: Mon, 30 Dec 2002 18:26:51 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Felix Domke <tmbinc@elitedvb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
Message-ID: <20021230232651.GB30238@mark.mielke.cc>
References: <20021230122857.GG10971@wiggy.net> <200212301249.gBUCnXrV001099@darkstar.example.net> <20021230131725.GA16072@suse.de> <32797.62.98.199.18.1041274402.squirrel@webmail.roma2.infn.it> <20021230190034.GG3143@conectiva.com.br> <3E109EF1.5040901@WirelessNetworksInc.com> <3E10AFE7.6030301@elitedvb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E10AFE7.6030301@elitedvb.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 09:43:19PM +0100, Felix Domke wrote:
> Anyhow, sorry, i really can't understand that. What could be more 
> "indention war preventing" that letting everybody use his own indention 
> width?

If everybody had exclusive ownership of code sections, and only they ever
made changes to that code in the time before, now, and after, than nothing.

In the more practical world, and especially for code architects, or
senior programmers, every user touches every other users code.

If they each adjusted their style to match the code they were editting,
this would be an unacceptable overhead. If they each casually adjusted
the style of the code to their own style and editor setting, the code
becomes a mess (different styles of indentation used within the same
function body, etc.). Also, they become tempted to indent the surrounding
code to their style (even if this introduces whitespace only changes into
the code stream) as their style may conflict.

Style should be determined per product, or at least per component. I
would say style should be determined universally, but that would not
be practical, nor would it encourage creativity.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

