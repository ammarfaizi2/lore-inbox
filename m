Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318023AbSGRGsR>; Thu, 18 Jul 2002 02:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318024AbSGRGsR>; Thu, 18 Jul 2002 02:48:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37636 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318023AbSGRGsQ>; Thu, 18 Jul 2002 02:48:16 -0400
Message-ID: <3D3662F6.1010206@zytor.com>
Date: Wed, 17 Jul 2002 23:40:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, viro@math.psu.edu,
       trond.myklebust@fys.uio.no, mnalis-umsdos@voyager.hr, aia21@cantab.net,
       al@alarsen.net, asun@cobaltnet.com, bfennema@falcon.csc.calpoly.edu,
       dave@trylinux.com, braam@clusterfs.com, chaffee@cs.berkeley.edu,
       dwmw2@infradead.org, eric@andante.org, hch@infradead.org,
       jaharkes@cs.cmu.edu, jakub@redhat.com, jffs-dev@axis.com,
       mikulas@artax.karlin.mff.cuni.cz, quinlan@transmeta.com,
       reiserfs-dev@namesys.com, mason@suse.com, rgooch@atnf.csiro.au,
       rmk@arm.linux.org.uk, shaggy@austin.ibm.com, tigran@veritas.com,
       urban@teststation.com, vandrove@vc.cvut.cz, vl@kki.org,
       zippel@linux-m68k.org, ahaas@neosoft.com
Subject: Re: Remain Calm: Designated initializer patches for 2.5
References: <20020718032331.5A36644A8@lists.samba.org>	<3D366103.8010403@zytor.com> <20020717.232832.44968023.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: "H. Peter Anvin" <hpa@zytor.com>
>    Date: Wed, 17 Jul 2002 23:32:35 -0700
>    
>    As far as I could tell, *ALL* of these changes broke text alignment in 
>    columns.  It would have been a lot better if they had maintained 
>    spacing; I find the new code much more cluttered and hard to read.
> 
> I have to admit that I hate the new syntax too.  The GCC syntax is
> so much nicer.

The C99 syntax actually has some advantages (I believe it lets you 
initialize array elements in a saner way), but my complaint had to do 
with the fact that whitespace for alignment wasn't preserved.

	-hpa

