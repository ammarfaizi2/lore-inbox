Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVJNQgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVJNQgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 12:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVJNQgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 12:36:40 -0400
Received: from qproxy.gmail.com ([72.14.204.199]:65256 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750794AbVJNQgk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 12:36:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m3fqx/9wnmlRB5yWrNyEu5I351HfU/KeqsPapPLsPZH3PU3dXMkXBk6pUkCR0kLdwRUH9mglgleGnOVwb+lN/wpoAc9r6tsQIScfMnYz1WG9J17zvq/fw69EpG0t72ZzrQCv7JqVY/8w1OjMJc+eb8UssTc7wlWmzY+Unnz5amg=
Message-ID: <d120d5000510140936i1148465budb2cf5ea22b967e2@mail.gmail.com>
Date: Fri, 14 Oct 2005 11:36:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Christoph Hellwig <hch@infradead.org>, Greg KH <gregkh@suse.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
In-Reply-To: <20051014095248.GA22670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051013020844.GA31732@kroah.com>
	 <20051014095248.GA22670@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/05, Christoph Hellwig <hch@infradead.org> wrote:
> NACK.  The whole point of classes is to have common attributes and
> behaviours over a set of devices.  There's much more than the dev
> attribute to them.  Please just fix the input code to get their
> semantics right instead.
>

What kind of changes would you like to see in the input system?
Currently it maps perfectly well on to what we have in sysfs (using
pair of input and input_dev classes), it is just that we do not really
like the general sysfs structure and would like to improve it.

--
Dmitry
