Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVGDKsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVGDKsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVGDKsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:48:08 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:10110 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261600AbVGDKqH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:46:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q8V10t8oAsvajTEvWr9452z9xFIMwXMZNjKqy96gJ16xaKr0DDJl0VMr4LiBCXPH3iyht/QkR2UY1n4VX/GjAu09SSje75Q292ylUwPGfCPBdGJSBl+5g4tPVtJ3Scb8yTaVJsGCNJnzeUPl3N/+a7DhStS+XY4cz8MqoP20W6c=
Message-ID: <84144f02050704034674ee702d@mail.gmail.com>
Date: Mon, 4 Jul 2005 13:46:04 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: FUSE merging?
Cc: pavel@suse.cz, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-Reply-To: <E1DpMqc-00065G-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	 <20050630235059.0b7be3de.akpm@osdl.org>
	 <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	 <20050701001439.63987939.akpm@osdl.org>
	 <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <20050701010229.4214f04e.akpm@osdl.org>
	 <20050703193941.GA27204@elf.ucw.cz>
	 <E1DpMTJ-000639-00@dorka.pomaz.szeredi.hu>
	 <20050704084900.GG15370@elf.ucw.cz>
	 <E1DpMqc-00065G-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> Here are some numbers on the size these filesystems as in current -mm
> ('wc fs/${fs}/* include/linux/${fs}*')

Sloccount [1] gives more meaningful numbers than wc:

('sloccount fs/${fs}/* include/linux/${fs}*')

nfs:  21,046
9p:    3,856
coda:  3,358
fuse:  2,829

  1. http://www.dwheeler.com/sloccount/

                              Pekka
