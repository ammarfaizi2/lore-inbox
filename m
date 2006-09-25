Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWIYRQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWIYRQi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWIYRQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:16:36 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:29795 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751309AbWIYRQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:16:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dHeoxDaWbYn7qVFgWsKYss9X/UnEWYjE6ePUvSjifOWTNFJR64Y0XzprbyeAqcyHl/4n1afFP9nqqkTjKZ+frOUQFwjzX3rUuiv6hH3EAq9njRHoG9+yAuX4FZGmvj7+oiUuzUFFms7yXBiyaikKA7ASRa6nPwyq+IE2hycaPqo=  ;
Message-ID: <20060925171634.69667.qmail@web31809.mail.mud.yahoo.com>
Date: Mon, 25 Sep 2006 10:16:34 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] fix idiocy in asd_init_lseq_mdp()
To: dougg@torque.net, Al Viro <viro@ftp.linux.org.uk>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4517EBF7.4020508@torque.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Douglas Gilbert <dougg@torque.net> wrote:
> Al Viro wrote:
> > To whoever had written that code:
> > 
> > a) priority of >> is higher than that of &
> > b) priority of typecast is higher than that of any binary operator
> > c) learn the fscking C
[...]
> BTW Luben was pointing out that the call you patched
> and the following call can be combined into a less
> trouble prone asd_write_reg_dword() call.

More than that -- I looked at the history of that
file/line and the code as I had written it _never_ had
that broken cast and shift mess.

"Someone" changed that after I submitted the code to lkml/lsml.

    Luben

