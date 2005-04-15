Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVDOTfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVDOTfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVDOTfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:35:08 -0400
Received: from waste.org ([216.27.176.166]:29099 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261932AbVDOTfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:35:04 -0400
Date: Fri, 15 Apr 2005 12:34:46 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux@horizon.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fortuna
Message-ID: <20050415193446.GY3174@waste.org>
References: <20050414133336.GA16977@thunk.org> <20050415013417.3536.qmail@science.horizon.com> <20050415144216.GA9352@thunk.org> <20050415162225.GA23277@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415162225.GA23277@certainkey.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 12:22:25PM -0400, Jean-Luc Cooke wrote:
> And the argument that "random.c doesn't rely on the strength of crypto
> primitives" is kinda lame, though I see where you're coming from.  random.c's
> entropy mixing and output depends on the (endian incorrect) SHA-1
> implementation hard coded in that file to be pre-image resistant.  If that
> fails (and a few other things) then it's broken.

You really ought to look at the _current_ implementation. There is no
SHA1 code in random.c. 

-- 
Mathematics is the supreme nostalgia of our time.
