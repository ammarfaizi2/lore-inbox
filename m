Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVLAVEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVLAVEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVLAVEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:04:55 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:27345 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932466AbVLAVEy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:04:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TNiyvCU3Ib0gcgLWDoTdLKkJziFrpYVCEm6VF0SGPvNk5Ta2FsmKWqfESZPzGJHxar+q/Yh/PDOVNgTQ760L/ZuK0xkd1xx+ghLIvMfudRVth/yb5mh0NAasYhugcvUnsxGqm2e3In5llsBQyfRt2m6sYXr5FNltwbmMmWkVfUo=
Message-ID: <9611fa230512011247ifc0d0d1xb92849dbe63d1325@mail.gmail.com>
Date: Thu, 1 Dec 2005 20:47:37 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [BUG]: Software compiling occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
Cc: Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511301347490.14736@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
	 <1132917564.7068.41.camel@laptopd505.fenrus.org>
	 <9611fa230511270317led5b915h7daae3ef1287f86d@mail.gmail.com>
	 <1133092701.2853.0.camel@laptopd505.fenrus.org>
	 <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
	 <20051127165733.643d5444.akpm@osdl.org>
	 <9611fa230511291357g3aa964adj6918fea50f5ee66e@mail.gmail.com>
	 <20051129151044.7ce3ef4a.akpm@osdl.org>
	 <Pine.LNX.4.64.0511301347490.14736@hermes-1.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/05, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> Yes.  (-:
>
> These just means that you have mounted with a bad default code page or
> whatever you want to call it and the ntfs volume contains characters
> whethe the Unicode (i.e. NTFS) to your code page conversion fails (NLS
> conversion returns error due to non-existant character in your code page).
> As the message suggests if you adjust your mount options to include the
> "nls=utf8" option the errors will go away and everything will work except
> maybe your terminal/gui may dislay some garbage characters if it does not
> understand utf8 characters but at least you will see all
> files/directories.

Hi,

I mounted with "nls=utf8" option as you mentioned and all the related
error messages disappeared. Thanks :)

Regards
