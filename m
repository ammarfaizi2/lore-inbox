Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbTBHU3f>; Sat, 8 Feb 2003 15:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbTBHU3e>; Sat, 8 Feb 2003 15:29:34 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:13276 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267124AbTBHU3d>; Sat, 8 Feb 2003 15:29:33 -0500
Date: Sat, 8 Feb 2003 07:37:53 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Tom Lendacky <toml@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPSec: PFKey patch
Message-ID: <20030208073753.D641@nightmaster.csn.tu-chemnitz.de>
References: <3E441910.2000003@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3E441910.2000003@us.ibm.com>; from toml@us.ibm.com on Fri, Feb 07, 2003 at 02:37:36PM -0600
X-Spam-Score: -2.5 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18hbko-000711-00*lzetqh3EmaU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Fri, Feb 07, 2003 at 02:37:36PM -0600, Tom Lendacky wrote:
> -	size = sizeof(struct sadb_msg) +
> +	return sizeof(struct sadb_msg) +
>   		sizeof(struct sadb_lifetime) * 3 +
>   			sizeof(struct sadb_address)*2 +
>   				sizeof(struct sockaddr_in)*2 + /* XXX */
>   					sizeof(struct sadb_x_policy) +
>   						xp->xfrm_nr*(sizeof(struct sadb_x_ipsecrequest) +
>   							     sizeof(struct sockaddr_in)*2);

Could you indent this monster more equally like

   return sizeof(struct foo)
         + sizeof(struct bar) * 2
         + sizeof(struct boom);

Thanks, that will help our eyes ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
