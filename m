Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbULQC2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbULQC2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 21:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbULQC2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 21:28:16 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:13460 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262721AbULQC1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 21:27:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TebL76RdKD/sUWW6G0N1OSJkUMiIQUWJ28qP2bYE3lGxr8BMO4NDHe5/YPlyLTKu7PyKmq0T9lKtyg0kOR+oMNVUw9DKyHxCLIiJWAMsbjnBK3QcexhjyQ2828sjRG4Yj7uuQSWMGeWWGvhJUVfeYM8NAPfMhfaoKUPx81q0Eq8=
Message-ID: <cce9e37e04121618275ad611bc@mail.gmail.com>
Date: Fri, 17 Dec 2004 02:27:44 +0000
From: Phil Lougher <phil.lougher@gmail.com>
Reply-To: Phil Lougher <phil.lougher@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
In-Reply-To: <E1Cf4wA-0008U5-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041216144531.3a8d988c@lembas.zaitcev.lan>
	 <E1Cf4wA-0008U5-00@calista.eckenfels.6bone.ka-ip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004 00:21:34 +0100, Bernd Eckenfels
<ecki-news2004-05@lina.inka.de> wrote:
> In article <20041216144531.3a8d988c@lembas.zaitcev.lan> you wrote:
> > Otherwise, /dbg sounds good.
>
> I dont think that a root level directory, especially with an unreadable name
> is a good idea. Why dont we at least try to keep the  namespace clean?

Are you suggesting we should rename "etc", "mnt" etc? :-)  I like
"/dbg" it follows the gdb, kgdb naming convention and it was the Unix
way to name things like this.  Though perhaps debugfs should have been
named dbgfs in this case...

I don't like "/.debug", hiding it in way this implies that you don't
think it should be there (and so you've hidden it).  A properly
decided upon mount point shouldn't have these connotations?  If you're
using debugfs I think you should want to have the mount point visible.

Phillip
