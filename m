Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263400AbTCNQoh>; Fri, 14 Mar 2003 11:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263401AbTCNQoh>; Fri, 14 Mar 2003 11:44:37 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:12444 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263400AbTCNQog>; Fri, 14 Mar 2003 11:44:36 -0500
Date: Fri, 14 Mar 2003 17:55:21 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: braam@clusterfs.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix stack usage in fs/intermezzo/journal.c
Message-ID: <20030314165521.GE23161@wohnheim.fh-wedel.de>
References: <20030314155352.GD27154@wohnheim.fh-wedel.de> <20030314080930.5ff3cc80.rddunlap@osdl.org> <20030314164445.GC23161@wohnheim.fh-wedel.de> <20030314084536.522ad81c.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030314084536.522ad81c.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 March 2003 08:45:36 -0800, Randy.Dunlap wrote:
> 
> If you are concerned about namespace & collisions, you can
> #undef BUF_SIZE
> after each function.

Not, if BUF_SIZE was #defined before and should maintain that value.
I could go and check for this specific case, but this is better left
to the maintainer, imho.

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class
