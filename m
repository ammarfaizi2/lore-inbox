Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbQLGOhT>; Thu, 7 Dec 2000 09:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130549AbQLGOhJ>; Thu, 7 Dec 2000 09:37:09 -0500
Received: from Cantor.suse.de ([194.112.123.193]:50698 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130546AbQLGOg4>;
	Thu, 7 Dec 2000 09:36:56 -0500
Date: Thu, 7 Dec 2000 15:06:18 +0100
From: Andi Kleen <ak@suse.de>
To: Daniel Walton <zwwe@opti.cgi.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Out of socket memory? (2.4.0-test11)
Message-ID: <20001207150618.A25095@gruyere.muc.suse.de>
In-Reply-To: <5.0.2.1.2.20001206223822.03997008@209.54.94.12>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20001206223822.03997008@209.54.94.12>; from zwwe@opti.cgi.net on Wed, Dec 06, 2000 at 10:56:32PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 10:56:32PM -0600, Daniel Walton wrote:
> 
> Hello,
> 
> I've been having a problem with a high volume Linux web server.  This 
> particular web server used to be a FreeBSD machine and I've been trying to 
> successfully make the switch for some time now.  I've been trying the 2.4 
> development kernels as they come out and I've been tweaking the /proc 
> filesystem variables but so far nothing seems to have fixed the 
> problem.  The problem is that I get "Out of socket memory" errors and the 
> networking locks up.  Sometimes the server will go for weeks without 

You should probably first find out what and why is generating these messages.
It isn't the kernel. When the web server is generating when a send blocks
then it is badly broken.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
