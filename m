Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317783AbSGVT6K>; Mon, 22 Jul 2002 15:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317788AbSGVT6K>; Mon, 22 Jul 2002 15:58:10 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:7412 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317783AbSGVT6J>; Mon, 22 Jul 2002 15:58:09 -0400
Date: Mon, 22 Jul 2002 16:01:18 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marcin Dalecki <dalecki@evision.ag>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 enum
Message-ID: <20020722160118.G6428@redhat.com>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> <3D3BE421.3040800@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D3BE421.3040800@evision.ag>; from dalecki@evision.ag on Mon, Jul 22, 2002 at 12:53:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 12:53:21PM +0200, Marcin Dalecki wrote:
> - Fix a bunch of places where there are trailing "," at the
>    end of enum declarations.

Please don't apply this.  By leaving the trailing "," on enums, additional 
values can be added by merely inserting an additional + line in a patch, 
otherwise there are excess conflicts when multiple patches add values to 
the enum.

		-ben
