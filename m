Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRC3CfP>; Thu, 29 Mar 2001 21:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130433AbRC3CfE>; Thu, 29 Mar 2001 21:35:04 -0500
Received: from monza.monza.org ([209.102.105.34]:47378 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S130388AbRC3CfC>;
	Thu, 29 Mar 2001 21:35:02 -0500
Date: Thu, 29 Mar 2001 18:34:04 -0800
From: Tim Wright <timw@splhi.com>
To: Justin Carlson <carlson@sibyte.com>
Cc: Xavier Ordoquy <xordoquy@aurora-linux.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug in the file attributes ?
Message-ID: <20010329183404.B4053@kochanski>
Reply-To: timw@splhi.com
Mail-Followup-To: Justin Carlson <carlson@sibyte.com>,
	Xavier Ordoquy <xordoquy@aurora-linux.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103292011480.20805-100000@ilaws.aurora-linux.net> <0103291053110G.04063@plugh.sibyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <0103291053110G.04063@plugh.sibyte.com>; from carlson@sibyte.com on Thu, Mar 29, 2001 at 10:51:18AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 10:51:18AM -0800, Justin Carlson wrote:
> You don't need write perms on a file to remove it, you need write perms on the
> directory.  If you've got write permissions on the directory, you can remove
> any file in the directory, regardless of the permissions.
> 
> -Justin

Except when the "sticky" bit is set. This is useful for shared temporary
directories. Files can be created by anyone, but they can only be unlinked
by the owner or by the superuser. Take a look at the permissions of /var/tmp.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
