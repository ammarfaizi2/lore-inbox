Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313157AbSDMLyd>; Sat, 13 Apr 2002 07:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSDMLyc>; Sat, 13 Apr 2002 07:54:32 -0400
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:6410 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S313157AbSDMLyb>; Sat, 13 Apr 2002 07:54:31 -0400
Date: Sat, 13 Apr 2002 13:54:30 +0200
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: tulip and VLAN tagging - accepting larger frames without affecting higher layers?
Message-ID: <20020413135430.A5521@torres.ka0.zugschlus.de>
In-Reply-To: <E16veWm-00052F-00@janet.int.toplink-plannet.de> <20020411152327.GA600@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 07:23:27PM +0400, Paul P Komkoff Jr wrote:
> It contains (following) (rediffed) working tulip mtu patch :)

That patch solved my problem.

With that driver, the MTU still shows as 1500 bytes, while I thought
that patch would cause the MTU to go up to 1504 bytes.

Will this patch be in the mainstream kernel soon? Or could it have
negative effects?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
