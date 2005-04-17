Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVDQQMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVDQQMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 12:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVDQQMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 12:12:18 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:46263 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261347AbVDQQMN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 12:12:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VBHp8AoJpEi5mivettwiEdmG90hLv587lkO5HLkqwLOyL2H0Glt7G9HU5niyiMHeAtNYk8GjW2yG9Bp7ytcp1KSFrqvMeDBTkkbk4lLBgM+9KGPb8/MY1oVwKDSzATFwonUrFxMTj6APv+qlXXv8hMg57mEwrNROSVqJU0DmEvk=
Message-ID: <4ae3c140504170912b36e9b1@mail.gmail.com>
Date: Sun, 17 Apr 2005 12:12:13 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Why Ext2/3 needs immutable attribute?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050417160306.GB777@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c14050417085473bd365f@mail.gmail.com>
	 <20050417160306.GB777@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply. 

Yes. I know,  with immutable,  even root cannot modify sensitive
files. What I am curious is if an intruder has root access, he may
have many ways to turn off the immutable protection and modify files. 
So immutable is designed just to prevent a valid root from making
silly mistakes?

Xin


On 4/17/05, Willy Tarreau <willy@w.ods.org> wrote:
> On Sun, Apr 17, 2005 at 11:54:34AM -0400, Xin Zhao wrote:
> > Why not simply unset the write bit for all three groups of users?
> > That seems to be enough to prevent file modification.
> >
> > Immutable seems to only add one more protection level in case of
> > misconfiguration on standard access right bits.  Is that right?
> 
> With immutable, even root cannot modify the file accidentely. It is
> very useful for critical configuration files.
> 
> Willy
> 
>
