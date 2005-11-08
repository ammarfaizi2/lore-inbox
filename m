Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965277AbVKHTNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbVKHTNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965269AbVKHTNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:13:45 -0500
Received: from main.gmane.org ([80.91.229.2]:40579 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965278AbVKHTNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:13:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Highpoint IDE types
Date: Tue, 08 Nov 2005 21:02:09 +0200
Message-ID: <pan.2005.11.08.19.02.09.190896@sci.fi>
References: <1131471483.25192.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181093116.pp.htv.fi
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Cc: linux-ide@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2005 17:38:02 +0000, Alan Cox wrote:

> Ok thanks to Sergei I can now post what I think is the complete table of
> HPT chip versions:
> 
>         Chip                    PCI ID          Rev
>  *      HPT366                  4 (HPT366)      0
>  *      HPT366                  4 (HPT366)      1    
>  *      HPT368                  4 (HPT366)      2      
>  *      HPT370                  4 (HPT366)      3      
>  *      HPT370A                 4 (HPT366)      4      
>  *      HPT372                  4 (HPT366)      5     
>  *      HPT372N                 4 (HPT366)      6     
>  *      HPT372                  5 (HPT372)      0
          ^^^^^^

This one is called HPT372A by Highpoint's BIOS/Win drivers.

Also I'm not sure if it's relevant but PCI ID 5 chips use a different
BIOS image than PCI ID 4 chips.
       
>  *      HPT372N                 5 (HPT372)      > 0     
>  *      HPT302                  6 (HPT302)      *       
>  *      HPT302N                 6 (HPT302)      > 1    
>  *      HPT371                  7 (HPT371)      *      
>  *      HPT371N                 7 (HPT371)      > 1     
>  *      HPT374                  8 (HPT374)      *     
>  *      HPT372N                 9 (HPT372N)     *     

This last one is not listed in the Win drivers at all. Strange.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/


