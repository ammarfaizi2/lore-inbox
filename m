Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSIDXgo>; Wed, 4 Sep 2002 19:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSIDXgo>; Wed, 4 Sep 2002 19:36:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33762 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316512AbSIDXgm>;
	Wed, 4 Sep 2002 19:36:42 -0400
Date: Wed, 04 Sep 2002 16:34:10 -0700 (PDT)
Message-Id: <20020904.163410.36853929.davem@redhat.com>
To: mason@suse.com
Cc: shaggy@austin.ibm.com, szepe@pinerecords.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1031171361.10959.179.camel@tiny>
References: <200209042018.g84KI6612079@shaggy.austin.ibm.com>
	<1031171361.10959.179.camel@tiny>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Mason <mason@suse.com>
   Date: 04 Sep 2002 16:29:21 -0400
   
   The patch will probably cause reiserfs problems as well, we've already
   got people with > 32767 links on disk, going to a lower number will
   confuse things.
   
And that means you already have reiserfs partitions that cannot
be used on other Linux platforms.  That's pretty bad.

   
