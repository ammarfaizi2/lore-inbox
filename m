Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSGOQNk>; Mon, 15 Jul 2002 12:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSGOQNj>; Mon, 15 Jul 2002 12:13:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:58685 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317520AbSGOQNd>; Mon, 15 Jul 2002 12:13:33 -0400
Date: Mon, 15 Jul 2002 17:16:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: "Weber, Frank" <FWeber@ndsuk.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Process-wise swap-on/off option
In-Reply-To: <1A961872F9CE0B4AB641DD256115865F225C5E@tornado.uk.nds.com>
Message-ID: <Pine.LNX.4.21.0207151715420.1541-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Weber, Frank wrote:
> 
> Is it possible to arrange that a Linux application 
> (or one of its threads) has the ability to
> 
> 	"... lock (a certain) stack and data segment ... 
> 	into memory so that it can't be swapped out"?

man 2 mlock
man 2 mlockall

Hugh

