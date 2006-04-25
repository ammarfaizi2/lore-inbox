Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWDYKMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWDYKMo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWDYKMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:12:44 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:54075 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932174AbWDYKMo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:12:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lR03hDlN9zpg0dcuyLsc5HLFeuLvtjH7ACwD7BMkRJNMwrZMNiC0TaCM0HZbpRYNCp8U+kr4R5O+XPmA5rffAeMz9Iz2fIxuiojt4wQsDREzDyAqo3dH47Z82cVRoPJY78C7tauyjxEWRIm3fc7cxwIx3uNw0kGxd+gvfMHzTg0=
Message-ID: <84144f020604250312w43df9fb4n864647c8d313a588@mail.gmail.com>
Date: Tue, 25 Apr 2006 13:12:43 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "=?ISO-8859-1?Q?Jani-Matti_H=E4tinen?=" <jani-matti.hatinen@iki.fi>
Subject: Re: Lock-up with modprobe sdhci after suspending to ram
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

On 4/24/06, Jani-Matti Hätinen <jani-matti.hatinen@iki.fi> wrote:
>   I've tested this with 2.6.15-gentoo-r1 with the sdhci-0.11 patches
> and vanilla 2.6.17-rc2. Sadly nothing gets as far as to the log when
> the lock-up occurs.

If this is a regression from an earlier version, you could try git
bisect to isolate the broken changeset. See the following URL for more
details:

  http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt.

                                              Pekka
