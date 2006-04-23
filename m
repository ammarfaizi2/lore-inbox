Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWDWRAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWDWRAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 13:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWDWRAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 13:00:42 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:44248 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751426AbWDWRAl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 13:00:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n/z95ohuNLhgMLrXSj0oKwGJjdQIcHGivpfwqlWMZIFfDJgeH/7QYrFonNm3aYl09TrHs/llg+wEmrV9dK9UtB9Gs627nh7WIX8v+lNWkMW7pMs3IOGLXcdyXoobcoHeSfrqXzXGlDMU229BMy/OtuHE787/uErzAExo3IlwmhY=
Message-ID: <bda6d13a0604231000w4fee8d2fr6fb9d16a04b5741c@mail.gmail.com>
Date: Sun, 23 Apr 2006 10:00:41 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
In-Reply-To: <1145776170.3131.4.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422132032.GB5010@stusta.de>
	 <1145719812.11909.333.camel@pmac.infradead.org>
	 <200604222313.42976.arnd@arndb.de>
	 <1145776170.3131.4.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an old script lying around that does it the reverse way.
It is ran in /usr/include, and finds all #include <linux/* and
#include <asm/* and copies the files over. After doing so,
it repeats the pass until there are no more to copy. Interested?
