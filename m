Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132113AbQKZCkt>; Sat, 25 Nov 2000 21:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132114AbQKZCkj>; Sat, 25 Nov 2000 21:40:39 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:62583 "EHLO
        dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
        id <S132113AbQKZCkf>; Sat, 25 Nov 2000 21:40:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14880.29022.261932.284497@somanetworks.com>
Date: Sat, 25 Nov 2000 21:11:42 -0500 (EST)
From: "Georg Nikodym" <georgn@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <20001126023239.B7049@veritas.com>
In-Reply-To: <20001125211939.A6883@veritas.com>
        <Pine.LNX.4.21.0011252205500.768-100000@penguin.homenet>
        <20001126023239.B7049@veritas.com>
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@home.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AB" == Andries Brouwer <aeb@veritas.com> writes:

 AB> No insult intended.  It is just that if there is an abyss
 AB> somewhere, I like to stay at least a meter away from it. Someone
 AB> else may think that one inch suffices.  I see you propose a lot
 AB> of changes that yield a negligable advantage and reduce stability
 AB> a tiny little bit. That is pushing Linux in the direction of this
 AB> abyss. You notice that the view gets better, and I get nervous.

Can somebody stop this train load of bunk?

Uninitialized global variables always have a initial value of
zero.  Static or otherwise.  Period.

Anybody with more than a week's experience programming knows this.
It's idiomatic.  Just as in English one says, "Go away!" knowing that
"You", the implied subject of the imperative sentence, will be
understood.

Andries, please devote your impressive energy to fixing _real_ bugs.
This kind of argument is best left until we're _really_ low on other
things to do.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
