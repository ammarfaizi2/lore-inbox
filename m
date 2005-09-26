Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbVIZCnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbVIZCnP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 22:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbVIZCnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 22:43:14 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:38600 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751603AbVIZCnO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 22:43:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AKLmJszWkORPLPrnUjI/ODv2uNKZaJe6zB2KOBumKgg7L0yVT602KXGiOBQN2NGsGjX0IcvHOhgb3STitIh6L1CRZhIbZsj95jIgQZmd4ounzp3Yx5Zaw0Fiqnj+Zy9vS4zb/PT8+HxxdDegJHzK06bylQxn7bRn2UnJjWfuEl0=
Message-ID: <9e4733910509251943277f077a@mail.gmail.com>
Date: Sun, 25 Sep 2005 22:43:11 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: usb-snd-audio breakage
In-Reply-To: <9e4733910509251927484a70c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910509251927484a70c7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Redhat FC4 installer is adds index=0 in modprobe.conf. The index
parameter appears to have been removed fron snd-usb-audio.

There are two issues:
1) should index have been left as a non-functioning param so that
existing installs won't break.
2) Why didn't I get a decent error message about index being the
problem instead of the message about `'

On 9/25/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> usb-snd-audio broke in the last 24hrs in Linus' git tree. modprobe of
> the module fails. I  have a PSC805 USB audio device.
>
> modprobe snd-usb-audio
> err -> snd_usb_audio: Unknown parameter `'
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


--
Jon Smirl
jonsmirl@gmail.com
