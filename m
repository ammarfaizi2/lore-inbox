Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSIDXhq>; Wed, 4 Sep 2002 19:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSIDXhq>; Wed, 4 Sep 2002 19:37:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36578 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316519AbSIDXho>;
	Wed, 4 Sep 2002 19:37:44 -0400
Date: Wed, 04 Sep 2002 16:35:15 -0700 (PDT)
Message-Id: <20020904.163515.82835380.davem@redhat.com>
To: reiser@namesys.com
Cc: shaggy@austin.ibm.com, szepe@pinerecords.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com, green@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D766DA8.9030207@namesys.com>
References: <200209042018.g84KI6612079@shaggy.austin.ibm.com>
	<3D766DA8.9030207@namesys.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hans Reiser <reiser@namesys.com>
   Date: Thu, 05 Sep 2002 00:31:36 +0400

   The proper fix should be to make the result of the limit
   computation be accurately architecture specific.

And then each and every Reiserfs partition is platform specific
and cannot be mounted onto another Linux platform.

Creating such a restriction is a grave error.
