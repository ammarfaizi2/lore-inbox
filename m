Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbTIPTxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbTIPTxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:53:54 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:30214 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262484AbTIPTxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:53:47 -0400
Date: Tue, 16 Sep 2003 21:53:45 +0200
From: Olivier Galibert <galibert@limsi.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030916195345.GB68728@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@limsi.fr>,
	Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	neilb@cse.unsw.edu.au,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk> <20030916171057.GA8210@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20030916171057.GA8210@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2003 at 07:10:57PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Well, I do understand the bounce buffer problem, but honestly the current way
> > > of handling the situation seems questionable at least. If you ever tried such a
> > > system you notice it is a lot worse than just dumping the additional ram above
> > > 4GB. You can really watch your network connections go bogus which is just
> > > unacceptable. Is there any thinkable way to ommit the bounce buffers and still
> > > do something useful with the beyond-4GB ram parts?
> > 
> > The 2.6 tree is somewhat better about this but at the end of the day if
> > your I/O subsystem can't do the job your box will not perform ideally.
> > For some workloads its a huge win to have the extra RAM, for others the
> > I/O is a real pain. 
> 
> If he has trouble logging in, then there's a bug somewhere.
> Bounce buffers should not slow machine down more than
> 2x, and from his description it looks like way worse slowdown. 

The box does not just slowdown, the box crawls on the floor wimpering.
Nothing works except ping until the i/os are finished (and they seem
to crawl too), then everything works perfectly again.

We're quite eager to fix the problem too, if you want us to test some
things.

  OG.

--+QahgC5+KEYLbs62
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="info.txt.gz"
Content-Transfer-Encoding: base64

H4sICJZpZz8CA2luZm8udHh0AOxc63Paurb/3P4VmrM/3HZSWmwMIZmdPSNkA2r8imUI2Wc6
HgomYUqAy6O7OX/9XbJ52EYStKfp2edOOtMmaC0tSWv9tB6SqD2err+hvx76q/hrvHg/GT8u
x+9HC6S/N97remm+iC/Qbzpijo/ChzX6uJ6gioY07dIoXxp1RCwWIr1crqBxrV7b/FOBf1pu
54PNZb9+XS5flsvvy6g9W67Q58V4eB9fIjpdxRNEZov5+0vUmX6Zzv6aomH8dTyIkV41BujN
Iv6Kytrb16/Y+vPyabmKHy8RW8/jBXLGg8UM+j7O1yv4SKeDAxEVo15+/YrMpqvFbAKjffBK
yIkfz1BjvXT6IGxxhtg8HpCnwSROSLfU7ZZQt4XZdDabl5DfX1iLRQmxVTyfj6f38JsVBGeo
Cb0beqME81r1V+vlJSL9+Rmq1ZyHf5VQx2yWtixnOxmm1WWWfTWCdvRHiD/PFqsS+n33i7P5
5Q8+Anz2+Y/Xr2ywyXTwdIn4Svrz/ufxZLwaxzDi7/2v/fGk/3kSo9l08oRWM7SYzVZ/pLrW
Qdc+oSJVo/i8Wi6jf/qT9WN/+Qm1adRA3fFite5Pkj6NpA960yy/3VkAvZkvZvel8Qjxru5s
8QjMw3gwG8af3uaVfPacSi6lSj57HiXXjNevGnyk+WL82F88XZXL79ASVjkdJp80+LQGEcPx
FLpclSsJtTRJ+1+BjWD96HP8MJ4Od6ovw58K/C0lv4xGo9evQAuzxVORcTTQOEu5NBroo1HC
6C/iUbwaPCRmfhT3Go3SXvB30ys1IFmBPUAx49VTqtIScmeU4TOue7DEVhdBvIxXpb26E/xU
vgs/5AU/J+HHKOCndip+jC1+DCV+Klv8GP9h/GhDwE+HNdDGsJN4kcdQXa+XNYI/EOwkfG/a
68/oN20LGL0AmE6b0E8/LQwkCCv9uwgrKRF2JAw8xsPx+vEHAwFX5GKxnq8AaOMpwuD4YfVD
HgJocIO02utXQXw/nk2RkawXzUHiEvVXPEqDNpfjf8VXFf3T1lTaD5hKfzHVD5iqUTTVhcJU
usBU+g+YqvJiqh8wFSmaqq4wlXFgqlgRQBMzNbiZPpiNXMjkZjL0v1u0fL6UVhUszwvB8jwf
LHmslUTL6jZaVpXRsrqJlsPRc0fLsyPRcgRgAV45WAhO6FuY2D7Z7+mT8XD2i/Dw7+zCjTo0
RE0LjfmOHPUHMo0ASwdSZoF3q/fRP9P1IxYPfOQvxv5P9nRn/2/zh/LO0ZULju738f10toiH
f+w4tKMc+lGOylGOQ4db2zpcrfZpx1a9RJu9DjyjQbJRAR0VvfR5vHqHprMpP8vYbfG3WxHX
n7a4qyDmJD5JFlUTcmbrPU/oLP0XAOpIZlOWGk/TCjmodqkNeLSk5EDv52VfR37NaOtcxjcM
PBvlG5ndzhMl6r3pvS1xhk//VcdF+Uq09BNj634PZzeFduKmMGBTnH7ipKUVnyLhyViSJ6XF
pCdnz/9s0vO8hqkZ79CgP3iI0WQ8jRHXNdIOMiEtlwnphUxIPzkTGm0zobIqEzrMaU7IhMqb
P9neuT/fdY5wdpgZfRf64hcH8ssciPY8DmT04kCey4FU1OfWCgdy4sG1/gMH138jB1JJL0ys
1UO8mMYrNJCer1SNmtVArfE9CF7tO+wPZMR3VlkhfuB9SLaQEyIzOTOH6UOZsvgKvfGwPwc8
fj9az54XrT9eb9QM9KZWOa+Wp0v0OJ6+PURvuX60JNHrMnekb/KZmnEkydfr15+kOWllfy5a
Mz59L3K0F+T8bZBTrEP0Cyly9J+DHOPHkGO8VD2/LmmpPEvVY7xUPT81aTFySUu1kLRUX6qe
Ivpeqp5f50C053EgL1XPszmQmvq1hcKBnPjcwviB5xZ/IwdSS6seRhhFy9Vs0QdUZfPXNKM8
3PH1sjbawK+SdxqyHvwm7vsvi//WiWlyjpompu9QTU+T1P63HytvzmvSKxfD2FUmejVz16Hl
/ZNxvAwajpf8t+GnjbhsVlu8gjHKhVGtb/P+dMlZA89JLmnW0/5yOb6fxsM/DmVXNf27HGEt
LaNeoPjLoVisl87P5VAcnAhF/adCsf5roXh+WdbAK4K9AYGP8/5qzLlyYAwpCuPBw3Q2md2D
OJ4WoYBDtmenYNTPC2EZpBXyK5WQnxu1z1SXg2fPfNus6wBQfYfPH3OPWk2Slg1PvuKtOZ+k
d9bVshjXeh7X1e+pIb8TpJszhlNB+vq3178hvF7NHgGeg/4EiPfxNF70udI+P8Hu/8Lzj+ka
YDsa31+i4Wz6PysEVlxBV+K5TdqKevXa1RPI2XxkjQ5D4yUsawVp0mrL1aGmxvmSIQkklSB8
teZZCZrEXyFVnc1XsMzlXq7VAxBQx3JDbG872rP+ME2KZsM1/Fiu51z9+06OZ3ZsiwH/vqFr
BYx6bqbxGlq3Iv3FbBAvl7MFWj3NY9SHHGsU86nFy3SuGzn8iwiZZe0JhoxQVRBCRqQ0x+mJ
aTWZQB+URDsOpVSg+S3VyFrJuZaIuj6XtNfF7ZaNXTGFBB3mWWIa+BrSpj6pKcm6kloxJePe
BbRXUMWe2qWYVCJdoCfAcXTrR7decM0i73qPFk4A32j7rXwbcfweaRcae9g08y0Ndov9fJPv
+dhMx9jNLLhllhO1LBdATyLmU9f2yLVgnikjHxmGirDd8gIatp38CLYWEUzaVsTatBlenWdp
bcwiwF++Q8vzQBjU74WZtqx8Q4dZke8HXgTCyTXrFMZtlstNiQodYmXXG3owtQYWWonWRQt3
KAk84pmFGTksKNjFB2eTHcr12rTVdixHONiGZrQEQ25oNSNj5U1bQU/YynNQL7fdcNiOLKdj
Q7j2XNHawiCzCub42d58ALfjiHXFiWDNyISarmFbEmDn7N3GXSsyLRJxhG39YCtx/BPecT3f
O1TXCgs7wRPABARhu9DuE5pdBHwEkDWox4TLSMkmDSwSCtaQkrF7l5MfcXH5llTCvg20kmdw
sZPEh93IFn8RKfYkWAQJL/TtTmsXPohDKP5A+oshf9G1D0iZlXGOrKRNR4ras9V8sr7nh2TF
Xpth+JTFqN3TI+I5Pr45kS1yuwF2jjLTxnEeTHxRwGF3rAu+PavjBjMjcBrEYgx6CS0MvUho
Z2I08QIrsuxmVk7aiL1OKJxcg7pNJzyg56mpyHybQ7P7w3eyY2LfOTBesnKB1YoaSWib5G+X
pT8hM6khl+iNE5pvc1lGaB4CpQ/bcgIZEh/sMOPxceB7QQbxm4bIJ6I2iFq2ltuXGxIk3hTb
oq2379ukTU/UF0isw7M1T7y3N2zYoS2s5HCapKIWEeKAKjlaksxqt86O2/B9JYsXtq1AoQnI
so3d/uf7lyeN/qT/hNI8eQ0JNOSyGRu5fs4jpZ+T/o3JbPBlc6iQSX4b9jV46G7UzAWybWvP
lM0/ee4s2hnQk/g3kYmVZEJhg0p4Eho/WYlC7MtH4fMzMbmolZUsnUI4LpBtz/NFK3cbplKs
zLVt6dSlYWBKBmYhDtnWMM56shqXNqc9m12H3gSYmom57a6T37nqeUnIjhnZ1LVwIKPy8coq
oqYiVmVEyERC6kNSopw0rPHAG7nx6q/Z4st4en9YsfmYXCfpQgaRvCVyHCzecZBdwPqT0WT0
JrVDS6yfQ9K22HRpL7PhcjkM9dPVE8xyU4V2bHaxSyzQHQQQyZjABrtXNlkgUxWxFVgyqU4y
qJAKbkcMH76yyCLiAozduRDyvWtqMcmYXXH5dd0OQ8mAOBRvry5UgVG9rGs3kqF6EnHYvj4M
rvP5JF71J1m3uOvCcYl937aKXTMcBNQiBjb4x5ZYxz1dvFls7DfEBJtIDW3SrhWIp2DBT8ns
bkGHCuRxwU0ArRwnnKN9GzVt7xZagNE+0O3NjHH39WG2QKP+eIH+dx2vY9jMWRVzMQzKO1O2
+dEqXq4EnfzrEOrXg15hPInnD7Ppkyhj8tugD3E045SI9j6qqbL8GrD1AaLhB6fpfAhs+zBx
okkhmfDCr+94h8Szw09I4o7E5bTzgcdsm5EqAqcsirAHnaGOyxTOm4bUZfHDrNywWyoHxbV6
WGAlTD0yEeYaQDga74EHQOf7d8e4kosZoYcwLUgrYCnUgypAKYY4Zs0on8ASWW478efqWSXp
mFozaSlbaN8c1eRsxasi1sZQo9Dg5rALt5eDi5Xxluo1mw0PB+YxJXIRTS8oLCwDiXSICHdC
r4gWIHmufcdRcwSGDhb05WJvJRFu2xkDI/9qjpLHIjW911Pz2FSr9sTlwK1JlPSdDMc8NyTj
bGiRB746OLZrE0Sp5xsGtGlbah5yV9dJ7UI9acKq1Ypaf20/rEimk5IS45sOPiqlVlPgwKdJ
HnWYhbP6uaFVlcI9P6Q1XVPy+CbRyzq3gS2paLYMjU7AwtNkudatukT4M3mCo2JhRNOPsXRv
r5mag1IHt6wjPGBrTQ0HZpOLslWrHQGfo1+oZ9ylGMDXk+wG7oD5qTqzQiZ3KxKXQrviHInT
XM8tnGEdOpsksDER0ni9z0su5SZPeTgCTuID2J/Ex+jhWU76sqCYSvDWQ2/PMhcBzIysXhhg
TmBXRjlTVreDlFs8qS3ZY0fwz0SF0E545vw6KeFNq9FpRTcdq5O9LEtIaaphd9xCO/wOBbIb
5uyUUGyv1aJuS6ysyeyvUnrDN1yMv8aLXDa/nXzlNgJg9iKprZNxzmHfQgYsUUTCgoksgKbk
Ntaqeu8Ig6GrGc4l6UfKgIl6FZiS88IuLJIvepnyddPAQxCLfCsxKCXWVUUvcgQW48WHZeO7
yGFXGr9pzsS7DVejQ20TaufAucWScnTLarn8SiEKTJ5hOkrWFFBpB8HS8mwOZHpXgqkFFrj8
wArDO/hB3fCoEqWBIwW5DzW37imk8IKf3TE5B3V1WbBIJTjVCrk4N+QcjtXCakA0Ogx2ECVy
DuLfNEmomKbp9CrahabSRUgqel2xEovXP0pqJMsn9hw+VWi72Qk7kBmbnoOpK2drmZJjqZS6
uSB1SVCtqNYDoUxlVhqqpgp0aQ6bMPi+QhXUceTEZOLEKNfwMZ7zb9/kLOyOI68OW0A/Jqfe
650gR7FWzLSagkyoeo9wBl0vUwUHo7qhYrhJNgg//jjKQ5l/XA45yqIpNwuzcAtLTmFSBuqc
a+VjajdUejVJ5aKscIEhTFFO7WhGVDGaCgYb0hEWeoECPsyvKNCV+PKDoN9cJ8+VHEiy8ofn
2bjf7LDCPXiBFDU8L1TRKbNcZqk4ZOcIG3Lh3Up6DmRZFtIqFwZ60xwv4lv4+3Z/9p99kJQ7
++fdkl4H8iD4yJUgC03QLr325bRG8WFIjip7j8Np8uMXPmTgEemJ38Eq9sd+aTqyuzfBAeHf
RxQc3QKlcPS5LRM6jnN39ZhJCz3XLCSU+wPUmw5U/n9KDknDjnj1Fr/SC+W3EBFrFKvCZOq7
71e+gd08WyBgcj6PV29zGkilu/mrD9ZxbX76JC7Sse/fORYWI5RfUTqYyGg3lozSkjxx4XPs
Wq7pBVGFeI7koFs22Uxv5pBjLAGk4LbktF87l8QJfnKGJccZsjic3KhInm4kp9GSLZTQPH4v
pbQ2/3rsxtKZ633LleRppq2LTtQsLmifyycfIxf7uQNA5y6gB+8m9/Nl9UpdL0twBDhpi9d5
Z9m2d9uUpFpBXatdiHF0fVG3Jb1C2vJc8XFF0zQlL1Wo70uu7G3JUaIvuaBnhQ6JbbiXnsTL
JeKe7w1/TfvQf1z0h+PZ2+IFRYDNfNaX3k/MvsRTFPArTYHXChW3MWIoBEQGPQb7Pu+40hX0
p/v/oyw3+K0gSOHH/ipeL1DAlyiKKwAK8ULpwsTozXg6WvQX8fCtMCYF5uFVCmWmy78Clb45
z7FzSpHdmwwRMUv8wfKm5OdmWSXHAe8SVmpaOdsQM3I90f1AOvx0vubfiF+Io6jrS14DJZTo
2rpryK6XUw7H6zBLzfLRu1MzWN0CPZ3iQ3/RH/BvPB5cJHUzV9LdMDlc8ezMG8L0OU4uoCQt
W04xvlIWqxeCL5bce2x43PQ0x8TC1xD8Av2iHvnhXeZ0aN8Ik+i4IX/lntmzvGCXRGXfl2mP
v0IIBHkTESdMhwmKA2rNnSh1WGJP0RtL3p55E8W2DbvOdZ1A1h4dCMi85dOA7mNT9nha0w97
J9P7OIPNMx58WR5gN2phx+LvioQybygp6/IXN9R3KGx417Sl7xUcXsFB2AKMWpIjlYQpzeOi
xIpNTBTjXRMmJ97ikLRNryXwcqvBw3B2j/hbyYKXO+ySKTW+QXkZtWRHC5i/dZHkinwttpTK
e/rOeU1cRcmfSQahJAUIJS8SgspFTXxCxF8yUFlGxjz3TvCcsLnqz+N3CFIVNJrM5vMnxBu2
GXrqcXO1lhQ8uCUOs6bkrM+5xd1DZCcPpfg3e/qi8NkFr+5FIufYHPMvcCQhJdfjpuNJTqJu
+FPNrrgi5TcTTRY1RZcXKc0A4n73BxZUkEHSI/cKf9ucPG8Xvb7fMvByCQCWfxCJzYM5FGlR
IL6ewk1517aS5NsdKblhNdW0gyJ+T5apE8JLJafLj43cywH4qBDbxKFsQg4zPelsO0pqVyFW
oYKPTTVNlxEJOAehckLHz8GMs2XffnoXtVo5rz3PptkHan8CUx6UH1WTVJmQU/mjRspCKvHZ
DoWoLtVqTz6yGx6hSXDe9mW4SnZUfuXgN+SjpESHpyIK+oF29lQ/LG7/G7dnyAfcUCULg3xX
sWP0wkj8kbwU6mZTRZKM35FPPCVFtwENLekRT+KP2aE/Jp6JZYKTZMGx/vzTEy/c3TrYzOdu
Jf85/cZG/vsygeeFnCgWaeYEmEWJZhSSzHtr1nGD7Ft4fnpmFj5G3dy345jTkEKb+AoSjwvp
k1dGW67sCCtlTF46JcOr+fjjLiUDV6KrmpIHfkzJwBxs26anYnFtFTW52xZZK3VmKQa232ZY
jfm7YRQ+zfOpAlQCIb+WcXcPcUVJfBIFdqxFqxWmuZ2kvRvf7a8gQUJ2f3q/5t+SZgcnmjb3
GU3cscOrf4yXs3q9elHS/pFZMTDwb6H5uGVFRkX8fckc0/lJTOfV40z1avkUJv0UppOGO2Hi
9dopc6pppzCdMvFa5RQm4xSmU1QgeXhTYLo4znRROUHSxSkG/r/2rqVJURgIn+VX5DhzWEtw
FTiK5TqWWFqObu3OhcIQhFpCUjxcnV8/HXBGBDQe97AHrST9dYc8KDud7tbsPzBP5vcHnsnQ
b88TvLli7zuGXIyqPfLYgFKlvckRmhTRlyLkox5IEUMpQpciTPl8yAejykej3h7OfDkznPV9
8vYmebv5YTTNXixOWUQqDj+f+uR0VLF01c6IrxO7FvtZiVgZtdm9ymNk4lLybZf7Pklarxqt
pl8Sy2OvinkFHbLp7S7++aZFoGiuQ60oJxljWdDGYNnbyVuDZS5uGiIUuPhP6Ur/pZcKD5m5
uE+yr1Vh0Q7a/HguPFaFk/8NrVfg7gU8nyXZI+sOebb8OVu3XdYtRuJ6HNTXwsG5LrQlbP2y
EnAYmjirZcNOWE5WcuIZ2ycuD0JciS2qHLl+rzZNo7Yd7hI3ORWpPsKY1FjG/bZQ/zd7Zomz
uz3aXG3Eol34stfu9hX+mSSiI3K7HUjsscQJPahNSZxDt0W6NQXzHPkuDaMTUNSBQplHog6U
tbKIYtirnXNytqf1M/pFWPy0WTyj8WqLtK7Rm768K+k54QoA9ULk4uW9EKKbZrff05Qy9YlI
+AGtA1VDc0vxvfDg7HLBFDMliLKiUtb8Xs+/0DCj7qXm81ygTjBxUHTIEZNi6s9t0H3olRk6
imH85V/oyN2nogJs6ECFAQrxlKAsxYimCeIuQRQThI8GcjksaUo4olkClL2guAhTdgBYJtjg
txFHfpSnAfJENhXMQ0TpEflHEJWCWPho8IWCDGVU2bE9oyFPxfgHRr87HF6vkfp/jf6tNTKH
XV1XlA+4v6WDInYAAA==

--+QahgC5+KEYLbs62--
