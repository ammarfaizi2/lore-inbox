Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVGLGxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVGLGxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 02:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVGLGxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 02:53:11 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41119 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261217AbVGLGxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 02:53:10 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: sander@humilis.net, "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: kernel guide to space
Date: Tue, 12 Jul 2005 09:52:04 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20050711145616.GA22936@mellanox.co.il> <20050711153447.GA19848@favonius>
In-Reply-To: <20050711153447.GA19848@favonius>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507120952.04279.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 July 2005 18:34, Sander wrote:
> Michael S. Tsirkin wrote (ao):
> > 	Use tabs, not spaces, for indentation. Tabs should be 8
> > 	characters wide.
> 
> A tab is a tab. The editor/viewer can be configured to show 2, 3, 4, 8,
> any amount of characters, right?

text with 8-char tabs:

struct s {
        int n;          /* comment */
        unsigned int u; /* comment */
};

Same text viewed with tabs set to 4-char width:

struct s {
    int n;      /* comment */
    unsigned int u; /* comment */
};

Comments are not aligned anymore
--
vda

