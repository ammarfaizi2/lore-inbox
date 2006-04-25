Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWDYUd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWDYUd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWDYUd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:33:59 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:65302 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932298AbWDYUd6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:33:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F8loey1tt7GIWr/mtm9Sb6T6ui7YMVEIlhq7vhJhO7rQA5BeY0E3AbYjpmzjuy3ULNG4Os6jLSsuPBnOG/SGVhuyhaxr4E9Nq2rGlUdEJE5W9KcUZXx7kDQGgqZBeoG96iS3sGWiOA9u4gq/tmmn8ST6a+JBK+nqXoH3cb6fbs0=
Message-ID: <d120d5000604251333s7ee66f22h6ee92189233790ea@mail.gmail.com>
Date: Tue, 25 Apr 2006 16:33:57 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Subject: Re: Telling the kernel that keys need soft release?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060425202526.GA29169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060425202526.GA29169@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> Dell laptops have hotkeys on the top of the keyboard for "hibernate",
> "cd eject", "battery status" and so on. These can be mapped to
> appropriate keycodes, and life is good except for the fact that they
> never produce a key release event. The kernel appears to have code to
> deal with this for the hangul key, but it's hardcoded rather than
> generic.
>
> Is there any way for userspace to tell the event layer that a certain
> keycode should have soft-release? If not, would a patch for this be
> accepted?
>

Yes, with a proper DMI entry to activate it would be very welcome.

--
Dmitry
