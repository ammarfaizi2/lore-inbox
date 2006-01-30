Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWA3FEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWA3FEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 00:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWA3FEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 00:04:13 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:7916 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750758AbWA3FEN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 00:04:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZRDxdIiL9nHQ1VU809prU/Jg0Mn8wh8k/5szPnELcPDB0chqmGpKZ+KHZPYwpq3Ijb9Of2gBqdtXU2FStSKiXbdnrGoobSBrYTZ7iVZAa8G287cnDiuzLTiylIzSpoNN3s9J2qM9H9vcpGzgUIUkD3o9zTRoIPdWuKKQgzQjsKg=
Message-ID: <1e62d1370601292104s3e8ad2bcx2d67e626cac04c8a@mail.gmail.com>
Date: Mon, 30 Jan 2006 10:04:12 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: sarat <saratkumar.koduri@gmail.com>
Subject: Re: insmod error
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aed62bae0601292023l641fb644k870a2b1b099e6dc3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aed62bae0601292023l641fb644k870a2b1b099e6dc3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/06, sarat <saratkumar.koduri@gmail.com> wrote:
> insmod: error inserting 'firewall.ko': -1 Unknown symbol in module
> plz tell me how to solve this..
>

Give the details of the unknown symbols in module error. This can be
get through log (run command dmesg, and see in the last about the
unresolved symbols) !

This error comes mostly due to missing header files in your module


--
Fawad Lateef
