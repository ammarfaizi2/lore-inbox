Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbVKCSgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbVKCSgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbVKCSgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:36:55 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:46555
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030416AbVKCSgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:36:54 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: tmpfs (documentation?) bug
Date: Thu, 3 Nov 2005 12:36:35 -0600
User-Agent: KMail/1.8
Cc: "Alexander E. Patrakov" <alexander@linuxfromscratch.org>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       LKML <linux-kernel@vger.kernel.org>
References: <436847DD.5050504@ums.usu.ru> <200511021658.57552.rob@landley.net> <Pine.LNX.4.61.0511031431550.23350@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511031431550.23350@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511031236.35452.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 08:41, Hugh Dickins wrote:
> On Wed, 2 Nov 2005, Rob Landley wrote:
> > So what's the new way to specify "this tmpfs mount should just be a
> > directory hierarchy with no data blocks" for those of us who _want_ the
> > old behavior?
>
> Sorry about that.  I guess you'll have to do the unaesthetic
>
> mount -t tmpfs -o nr_blocks=1 tmpfs /mountpoint
> echo full >/mountpoint/.full

Hmmm...  I suppose as long as I have the sucker mounted "noexec" I can live 
with that.

Rob
