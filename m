Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274085AbRIXRl6>; Mon, 24 Sep 2001 13:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274083AbRIXRl1>; Mon, 24 Sep 2001 13:41:27 -0400
Received: from t2.redhat.com ([199.183.24.243]:4335 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S274081AbRIXRlW>; Mon, 24 Sep 2001 13:41:22 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010924114037.A7561@codepoet.org> 
In-Reply-To: <20010924114037.A7561@codepoet.org>  <20010924002854.A25226@codepoet.org> <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <16995.1001284442@redhat.com> <32737.1001314127@redhat.com> 
To: andersen@codepoet.org
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Sep 2001 18:41:46 +0100
Message-ID: <26785.1001353306@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andersen@codepoet.org said:
>  This seems to fix it, but I'm not certain this is correct? Should /
> on jffs2 have neither inode nor dirent added?

inode for / is fine, although unnecessary. dirent you mustn't have.

--
dwmw2


