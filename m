Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131491AbRAWQ5B>; Tue, 23 Jan 2001 11:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131513AbRAWQ4v>; Tue, 23 Jan 2001 11:56:51 -0500
Received: from vitelus.com ([64.81.36.147]:41739 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S131491AbRAWQ4i>;
	Tue, 23 Jan 2001 11:56:38 -0500
Date: Tue, 23 Jan 2001 08:56:33 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Daniel Stone <daniel@kabuki.eyep.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and ipmasq modules
Message-ID: <20010123085633.D32100@vitelus.com>
In-Reply-To: <20010120144616.A16843@vitelus.com> <E14KsZI-0006IU-00@halfway> <20010122180158.B24670@vitelus.com> <E14Kxtc-0000KT-00@kabuki.eyep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14Kxtc-0000KT-00@kabuki.eyep.net>; from daniel@kabuki.eyep.net on Tue, Jan 23, 2001 at 06:29:34PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 06:29:34PM +1100, Daniel Stone wrote:
> Well, it's NAT'ing it OK. Are you sure you have a rule like the
> following:
> iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
> ?
# iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables: No chain/target/match by that name


Hmm??

I tried iptables -A INPUT -j ACCEPT and it did not fix DCC.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
