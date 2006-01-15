Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWAOU1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWAOU1M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWAOU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:27:12 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:25918 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932077AbWAOU1L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:27:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KqdtsQDyYa4XYdKhavsBZusxFCcCh0h4HsRABJMi3lTQxzxBh18DrbQuwf1G0EzSinYd4XD6EYFjwa5WJ3dhucSJmwnoSr20fUsk6sVuvUCf6/Oos9Li3yr1aQHXZajONzNzBRALJVJ2iHvWCasDKBe8MzCKd8ziOP27p1K6KX0=
Message-ID: <b6c5339f0601151227h33f511f2wbd581d02903c4145@mail.gmail.com>
Date: Sun, 15 Jan 2006 15:27:10 -0500
From: Bob Copeland <email@bobcopeland.com>
To: "pablo.ferlop@gmail.com" <pablo.ferlop@gmail.com>
Subject: Re: string to inode conversion
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1137354577.11981.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1137351430.11284.2.camel@localhost.localdomain>
	 <1137353054.3230.8.camel@laptopd505.fenrus.org>
	 <1137354577.11981.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/06, pablo.ferlop@gmail.com <pablo.ferlop@gmail.com> wrote:
> Basically I'm trying to learn how sys_open() goes from char *filename to
> a struct inode. I know (or think) that sys_open() doesn't actually use a
> struct inode, but I wonder how that would go.

Look at ext2_lookup in fs/ext2/namei.c for example.  It depends on the
filesystem.

-Bob
